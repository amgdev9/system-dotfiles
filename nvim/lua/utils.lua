local function safe_require(module)
    local status, result = pcall(require, module)
    if not status then
        return nil
    end
    return result
end

return {
    safe_require = safe_require,
}
