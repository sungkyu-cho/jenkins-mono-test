import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import { createApp } from 'vue'
import App from '../../App.vue'

describe('App.vue', () => {
  it('renders properly', () => {
    const wrapper = mount(App)
    expect(wrapper.exists()).toBe(true)
  })

  it('contains main content', () => {
    const wrapper = mount(App)
    expect(wrapper.text()).toContain('Jenkins Mono Repository')
  })

  it('has basic structure', () => {
    const wrapper = mount(App)
    expect(wrapper.find('div').exists()).toBe(true)
  })
})

describe('DOM Environment', () => {
  it('jsdom is working', () => {
    // jsdom이 제대로 작동하는지 확인
    const div = document.createElement('div')
    div.textContent = 'Test'
    document.body.appendChild(div)
    
    expect(document.body.contains(div)).toBe(true)
    expect(div.textContent).toBe('Test')
    
    document.body.removeChild(div)
  })
}) 