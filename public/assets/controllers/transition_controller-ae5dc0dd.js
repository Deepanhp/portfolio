import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.classList.add('page-transition')
    document.addEventListener('turbo:before-visit', this.handleBeforeVisit.bind(this))
    document.addEventListener('turbo:load', this.handleLoad.bind(this))
  }

  disconnect() {
    document.removeEventListener('turbo:before-visit', this.handleBeforeVisit.bind(this))
    document.removeEventListener('turbo:load', this.handleLoad.bind(this))
  }

  handleBeforeVisit(event) {
    // Store the current position of the profile image
    const profileImage = document.querySelector('[data-transition-target="profile-image"]')
    if (profileImage) {
      const rect = profileImage.getBoundingClientRect()
      sessionStorage.setItem('profileImagePosition', JSON.stringify({
        top: rect.top,
        left: rect.left,
        width: rect.width,
        height: rect.height
      }))
    }
    
    // Add exit animation
    this.element.classList.add('page-exit')
  }

  handleLoad() {
    // Add entrance animation
    this.element.classList.remove('page-exit')
    this.element.classList.add('page-enter')
    
    // Handle profile image transition
    const profileImage = document.querySelector('[data-transition-target="profile-image"]')
    const storedPosition = sessionStorage.getItem('profileImagePosition')
    
    if (profileImage && storedPosition) {
      const { top, left, width, height } = JSON.parse(storedPosition)
      const newRect = profileImage.getBoundingClientRect()
      
      // Calculate and apply the transform
      const translateX = left - newRect.left
      const translateY = top - newRect.top
      const scaleX = width / newRect.width
      const scaleY = height / newRect.height
      
      profileImage.style.transform = `translate(${translateX}px, ${translateY}px) scale(${scaleX}, ${scaleY})`
      
      // Reset transform after animation
      requestAnimationFrame(() => {
        profileImage.style.transition = 'transform 0.7s ease-in-out'
        profileImage.style.transform = 'none'
      })
    }
    
    // Clear stored position
    sessionStorage.removeItem('profileImagePosition')
  }
} 