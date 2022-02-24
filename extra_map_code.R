
```{r}
<<<<<<< HEAD
merged_plot <- merged_combined %>%
  # mutate(across(where(is.numeric), ~ round(., 3))) 
  select("Economic Need Index",long,lat)
=======
  merged_plot <- merged_combined %>% mutate(across(where(is.numeric), ~ round(., 3))) %>% select("Economic Need Index",long,lat)
>>>>>>> eb54a94bed3dd2507775730a13a0b48bdf4e080b
names(merged_plot)[1] <- "ENI"
merged_plot$ENI <- merged_plot$ENI*100
merged_plot <- na.omit(merged_plot)
merged_plot
```

<<<<<<< HEAD

=======
  >>>>>>> eb54a94bed3dd2507775730a13a0b48bdf4e080b
```{r}
nyc.map <- get_map(location = "New York City", zoom = 10, maptype = "roadmap")
ggmap(nyc.map, extend = "device", darken = 0.3) +
  stat_density2d(aes(x = long, y = lat, fill = ..level.., alpha = ..level..),
                 data = merged_plot, geom = "polygon", bins = 10) +
  scale_fill_gradient2(low = "yellow", mid = "blue", high = "firebrick2", midpoint = 80,
                       guide = guide_colorbar(title = "Level")) +
  theme_void()+
  geom_point(aes(x=long,y=lat,color=borough),data = gf_combined,size=0.7)
```

### NYC TRY

```{r}
<<<<<<< HEAD
library(ggmap)
library(data.table)

nyc.map <- get_map(location = "Bronx, New York City", zoom = 10, maptype = "roadmap")
data <- setDT(merged_plot)

# generate bins for the x, y coordinates
xbreaks <- seq(floor(min(data$lat)), ceiling(max(data$lat)), by = 0.01)
ybreaks <- seq(floor(min(data$long)), ceiling(max(data$long)), by = 0.01)

# allocate the data points into the bins
data$latbin <- xbreaks[cut(data$lat, breaks = xbreaks, labels=F)]
data$longbin <- ybreaks[cut(data$long, breaks = ybreaks, labels=F)]

# Summarise the data for each bin
datamat <- data[, list(ENI = mean(ENI)), 
                by = c("latbin", "longbin")]

# Merge the summarised data with all possible x, y coordinate combinations to get 
# a value for every bin
datamat <- merge(setDT(expand.grid(latbin = xbreaks, longbin = ybreaks)), datamat, 
                 by = c("latbin", "longbin"), all.x = TRUE, all.y = FALSE)

# Fill up the empty bins 0 to smooth the contour plot
datamat[is.na(ENI), ]$ENI <- 0
max(datamat$latbin)
max(datamat$longbin)
max(datamat$ENI)

# Plot the contours
ggmap(nyc.map, extent = "device") +
  stat_contour(data = datamat, aes(x = longbin, y = latbin, z = ENI, 
                                   fill = ..level.., alpha = ..level..), geom = 'polygon', binwidth = 100) +
  scale_fill_gradient(name = "Price", low = "green", high = "red")


```






### stack overflow example 

```{r}
library(ggmap)
library(data.table)

map <- get_map(location = "austin", zoom = 12)
data <- setDT(read.csv("data/sample_data.csv", stringsAsFactors = FALSE))


# convert the rate from string into numbers
data[, average_rate_per_night := as.numeric(gsub(",", "", 
                                                 substr(average_rate_per_night, 2, nchar(average_rate_per_night))))]

# generate bins for the x, y coordinates
xbreaks <- seq(floor(min(data$latitude)), ceiling(max(data$latitude)), by = 0.01)
ybreaks <- seq(floor(min(data$longitude)), ceiling(max(data$longitude)), by = 0.01)

# allocate the data points into the bins
data$latbin <- xbreaks[cut(data$latitude, breaks = xbreaks, labels=F)]
data$longbin <- ybreaks[cut(data$longitude, breaks = ybreaks, labels=F)]

# Summarise the data for each bin
datamat <- data[, list(average_rate_per_night = mean(average_rate_per_night)), 
                by = c("latbin", "longbin")]

# Merge the summarised data with all possible x, y coordinate combinations to get 
# a value for every bin
datamat <- merge(setDT(expand.grid(latbin = xbreaks, longbin = ybreaks)), datamat, 
                 by = c("latbin", "longbin"), all.x = TRUE, all.y = FALSE)

# Fill up the empty bins 0 to smooth the contour plot
datamat[is.na(average_rate_per_night), ]$average_rate_per_night <- 0

max(datamat$latbin)
max(datamat$longbin)
max(datamat$average_rate_per_night)

# Plot the contours
ggmap(map, extent = "device") +
  stat_contour(data = datamat, aes(x = longbin, y = latbin, z = average_rate_per_night, 
                                   fill = ..level.., alpha = ..level..), geom = 'polygon', binwidth = 100) +
  scale_fill_gradient(name = "Price", low = "green", high = "red") 
=======
  nyc.map <- get_map(location = "New York City", zoom = 10, maptype = "roadmap")
ggmap(nyc.map, extend = "device") +
  stat_summary_2d(data = merged_plot,aes(x = long, y = lat, z = ENI),alpha = 0.6)+
  scale_fill_gradient(name = "ENI", low = "green", high = "red")+
  geom_point(aes(x=long,y=lat,color=borough),data = gf_combined,size=0.7)
>>>>>>> eb54a94bed3dd2507775730a13a0b48bdf4e080b
```

```{r}
#https://stackoverflow.com/questions/45319970/generating-spatial-heat-map-via-ggmap-in-r-based-on-a-value
```

## plot with poverty
```{r}
head(merged_combined)
merged_plot <- merged_combined %>% mutate(across(where(is.numeric), ~ round(., 3))) %>% select("% Students with Disabilities",long,lat)
names(merged_plot)[1] <- "Dis"
merged_plot$Dis <- merged_plot$Dis*100
merged_plot <- na.omit(merged_plot)
merged_plot
```

```{r}
nyc.map <- get_map(location = "New York City", zoom = 10, maptype = "roadmap")
ggmap(nyc.map, extend = "device") +
  stat_summary_2d(data = merged_plot,aes(x = long, y = lat, z = Dis),alpha = 0.6)+
  scale_fill_gradient(name = "% Dis", low = "green", high = "red")+
  geom_point(aes(x=long,y=lat,color=borough),data = gf_combined,size=0.7)
```