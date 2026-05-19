#!/data/data/com.termux/files/usr/bin/bash
# Add stock images to GutWise blog posts
# Maps each post to a relevant image and inserts the img tag

IMGDIR="blog/img"
BLOGDIR="blog"

# Mapping: post-name -> image-file (without extension, will look for .jpg)
declare -A IMG_MAP
IMG_MAP["10-signs-unhealthy-gut"]="healthy-vegetables"
IMG_MAP["artificial-sweeteners-gut-microbiome"]="microbiome"
IMG_MAP["exercise-microbiome-gut-diversity"]="exercise"
IMG_MAP["fermented-foods-microbiome"]="fermented-foods"
IMG_MAP["fiber-types-prebiotics-gut-bacteria-microbiome"]="healthy-vegetables"
IMG_MAP["gut-brain-axis-second-brain-mood-sleep"]="brain-gut"
IMG_MAP["gut-brain-axis-serotonin"]="brain-gut"
IMG_MAP["gut-health-weight-loss"]="exercise"
IMG_MAP["gut-immune-connection-microbiome-immunity"]="microbiome"
IMG_MAP["gut-skin-axis-microbiome-skin-health"]="skin-health"
IMG_MAP["heal-gut-after-antibiotics"]="microbiome"
IMG_MAP["histamine-intolerance-gut-health-dao"]="healthy-vegetables"
IMG_MAP["how-sugar-damages-gut-microbiome"]="sugar-food"
IMG_MAP["hydration-digestive-health-gut-microbiome"]="hydration"
IMG_MAP["intermittent-fasting-gut-repair"]="healthy-vegetables"
IMG_MAP["leaky-gut-syndrome-science-intestinal-permeability"]="gut-anatomy"
IMG_MAP["microbiome-gut-liver-axis-detoxification"]="healthy-vegetables"
IMG_MAP["mouth-gut-connection-oral-microbiome"]="mouth-health"
IMG_MAP["natural-digestion-tips"]="healthy-vegetables"
IMG_MAP["pineal-gland-detox"]="meditation-mind"
IMG_MAP["postbiotics-butyrate-short-chain-fatty-acids-gut-health"]="fermented-foods"
IMG_MAP["seasonal-eating-gut-health-microbiome"]="healthy-vegetables"
IMG_MAP["self-responsibility-gut-health"]="stress"
IMG_MAP["sibo-small-intestinal-bacterial-overgrowth-causes-symptoms-healing"]="gut-anatomy"
IMG_MAP["sleep-gut-circadian-rhythm-microbiome"]="sleep"
IMG_MAP["stress-gut-connection-cortisol-axis"]="stress"
IMG_MAP["vagus-nerve-gut-health-digestion"]="brain-gut"

# The img tag HTML to insert
IMG_TEMPLATE='<img src="img/${IMG}" alt="${ALT}" style="width:100%;max-width:720px;height:auto;border-radius:12px;margin:0 auto 24px;display:block;" />'

# Alternative text for each image
declare -A ALT_MAP
ALT_MAP["healthy-vegetables"]="Fresh vegetables and ingredients for gut health"
ALT_MAP["microbiome"]="Gut microbiome concept illustration"
ALT_MAP["exercise"]="Exercise and physical activity for gut health"
ALT_MAP["fermented-foods"]="Fermented foods rich in probiotics"
ALT_MAP["brain-gut"]="Brain-gut axis connection concept"
ALT_MAP["skin-health"]="Skin health and gut connection"
ALT_MAP["sugar-food"]="Sugar and processed food harmful to gut"
ALT_MAP["hydration"]="Water for hydration and digestive health"
ALT_MAP["gut-anatomy"]="Digestive system anatomy"
ALT_MAP["mouth-health"]="Oral microbiome and mouth health"
ALT_MAP["meditation-mind"]="Meditation and mind-body connection"
ALT_MAP["sleep"]="Sleep and circadian rhythm"
ALT_MAP["stress"]="Stress management for gut health"

cd /data/data/com.termux/files/home/workspace/gutwise

for file in "$BLOGDIR"/*.html; do
    base=$(basename "$file" .html)
    img_base="${IMG_MAP[$base]}"
    
    if [ -z "$img_base" ]; then
        echo "SKIP $base — no image mapping"
        continue
    fi
    
    # Check if image exists
    img_file="$IMGDIR/${img_base}.jpg"
    if [ ! -f "$img_file" ]; then
        echo "SKIP $base — missing $img_file"
        continue
    fi
    
    # Check if already has an img tag
    if grep -q '<img src="img/' "$file"; then
        echo "SKIP $base — already has image"
        continue
    fi
    
    # Get alt text
    alt="${ALT_MAP[$img_base]:-Stock image for $base}"
    
    # Insert img tag after the header div (before <div class="content">)
    sed -i "s|<div class=\"content\">|<div class=\"content\">\n\n<img src=\"img/${img_base}.jpg\" alt=\"${alt}\" style=\"width:100%;max-width:720px;height:auto;border-radius:12px;margin:0 auto 24px;display:block;\" />|" "$file"
    
    echo "ADDED img to $base ($img_base.jpg)"
done

echo "Done with GutWise!"
