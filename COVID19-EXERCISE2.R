library(nCov2019)
get_nCov2019()
load_nCov2019()

require(nCov2019)
require(dplyr)

x <- get_nCov2019()
y <- load_nCov2019()

x
y

x['global']

# obtain top 10 country
d <- y['global'] #extract global data
d <- d[d$country != 'China',] #exclude China
n <- d %>% filter(time == time(y)) %>%
  top_n(10, cum_confirm) %>%
  arrange(desc(cum_confirm))

# plot top 10 on a graph since Feb 01 to most recent date in dataset
require(ggplot2)
require(ggrepel)
ggplot(filter(d, country %in% n$country, d$time > '2020-02-01'),
      aes(time, cum_confirm, color=country)) +
      geom_line() +
      geom_text_repel(aes(label=country),
      function(d) d[d$time == time(y),])

# worldwide growth on a map
x <- get_nCov2019()
x
plot(x)

# visualize global growth overtime

library(magick)
require(nCov2019)
x <- get_nCov2019()
y <- load_nCov2019()

y <- load_nCov2019()
d <- c(paste0("2020-02-", 1:29), paste0("2020-03-", 1:31))
img <- image_graph(1200, 700, res = 96)
out <- lapply(d, function(date){
  p <- plot(y, date=date,
            label=FALSE, continuous_scale = TRUE)
            print(p)
})
dev.off()
animation <- image_animate(img, fps=2)
print(animation)

