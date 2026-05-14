import { echarts } from '@/common'

let chinaMapRegistered = false

export async function registerChinaMap(): Promise<boolean> {
  if (chinaMapRegistered) return true
  try {
    // const res = await fetch('https://geo.datav.aliyun.com/areas_v3/bound/100000_full.json')
    const res = await fetch('/assets/100000_full.json')
    const geoJson = await res.json()
    echarts.registerMap('china', geoJson)
    chinaMapRegistered = true
    return true
  } catch {
    return false
  }
}

export function isChinaMapReady(): boolean {
  return chinaMapRegistered
}
