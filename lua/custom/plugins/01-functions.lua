-- livegrep search
function customSearchGrep()
  local extension = vim.fn.input 'Enter File Extension (*): '
  local dirs = vim.fn.input 'Enter Search Directories (.): '

  -- if escape is pressed, return
  if extension == '' and dirs == '' then
    return
  end

  if extension == '' then
    extension = '*'
  end
  if dirs == '' then
    dirs = '.'
  end

  vim.cmd('Telescope live_grep glob_pattern=*.{' .. extension .. '} search_dirs=' .. dirs)
end

function SearchAndReplace(search, replace)
  -- make sure search is not empty
  if search == '' then
    return
  end

  local command = ':%s/' .. search .. '/' .. replace .. '/g'
  local termcodes = vim.api.nvim_replace_termcodes(command, true, true, true)
  vim.api.nvim_feedkeys(termcodes, 'n', true)
end

function NextJSNewPage(pagename)
  local page_path = 'src/app/pages/' .. pagename .. '/page.tsx'
  local page_content = {}
  page_content[#page_content + 1] = [["use client"]]
  page_content[#page_content + 1] = [[import type { NextPage } from "next";]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[const Test: NextPage<{ someProps: string }> = (props) => {]]
  page_content[#page_content + 1] = [[  return <>Hello Test</>;]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export default Test;]]
  vim.fn.mkdir('src/app/pages/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

function NextJSNewApiGet(pagename)
  local page_path = 'src/app/api/' .. pagename .. '/route.ts'
  local page_content = {}
  page_content[#page_content + 1] = [[import { NextRequest, NextResponse } from "next/server";]]
  page_content[#page_content + 1] = [[// export const runtime = "edge";]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const OPTIONS = async () => {]]
  page_content[#page_content + 1] = [[  return NextResponse.json({]]
  page_content[#page_content + 1] = [[    status: "ok",]]
  page_content[#page_content + 1] = [[  });]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const GET = async (]]
  page_content[#page_content + 1] = [[  req: NextRequest,]]
  page_content[#page_content + 1] = [[  { params }: { params: { [s: string]: string } }]]
  page_content[#page_content + 1] = [[) => {]]
  page_content[#page_content + 1] = [[  try {]]
  page_content[#page_content + 1] = [[    const url = new URL(req.url);]]
  page_content[#page_content + 1] = [[    const {} = params ? params : {};]]
  page_content[#page_content + 1] = [[    const searchParams = new URLSearchParams(url.search);]]
  page_content[#page_content + 1] = [[    const test = searchParams.get("test");]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[    return NextResponse.json({ status: "ok", test });]]
  page_content[#page_content + 1] = [[  } catch (error) {]]
  page_content[#page_content + 1] = [[    return NextResponse.json({ err: (error as any).toString() });]]
  page_content[#page_content + 1] = [[  }]]
  page_content[#page_content + 1] = [[};]]
  vim.fn.mkdir('src/app/api/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

function NextJSNewApiPost(pagename)
  local page_path = 'src/app/api/' .. pagename .. '/route.ts'
  local page_content = {}
  page_content[#page_content + 1] = [[import { NextRequest, NextResponse } from "next/server";]]
  page_content[#page_content + 1] = [[// export const runtime = "edge";]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const OPTIONS = async () => {]]
  page_content[#page_content + 1] = [[  return NextResponse.json({]]
  page_content[#page_content + 1] = [[    status: "ok",]]
  page_content[#page_content + 1] = [[  });]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const POST = async (]]
  page_content[#page_content + 1] = [[  req: NextRequest,]]
  page_content[#page_content + 1] = [[  { params }: { params: { [s: string]: string } }]]
  page_content[#page_content + 1] = [[) => {]]
  page_content[#page_content + 1] = [[  try {]]
  page_content[#page_content + 1] = [[    const body = await req.json();]]
  page_content[#page_content + 1] = [[    const {}: { [key: string]: string } = body;]]
  page_content[#page_content + 1] = [[    const {} = params;]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[    return NextResponse.json({ status: "ok", body });]]
  page_content[#page_content + 1] = [[  } catch (error) {]]
  page_content[#page_content + 1] = [[    return NextResponse.json({ err: (error as any).toString() });]]
  page_content[#page_content + 1] = [[  }]]
  page_content[#page_content + 1] = [[};]]
  vim.fn.mkdir('src/app/api/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

function SvelteKitNewPage(pagename)
  local page_path = 'src/routes/' .. pagename .. '/+page.svelte'
  local page_content = {}
  vim.fn.mkdir('src/routes/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

function SvelteKitNewAPIPost(pagename)
  local page_path = 'src/routes/api/' .. pagename .. '/+server.ts'
  local page_content = {}
  page_content[#page_content + 1] = [[import { json } from "@sveltejs/kit";]]
  page_content[#page_content + 1] = [[import type { RequestHandler } from "./$types";]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[const headers = {]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Origin": "*",]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Methods": "GET,HEAD,PUT,PATCH,POST,DELETE",]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Headers": "Content-Type,authorization",]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const OPTIONS: RequestHandler = () => {]]
  page_content[#page_content + 1] = [[  return new Response("", {]]
  page_content[#page_content + 1] = [[    status: 200,]]
  page_content[#page_content + 1] = [[    headers,]]
  page_content[#page_content + 1] = [[  });]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[export const POST: RequestHandler = async ({ request, cookies }) => {]]
  page_content[#page_content + 1] = [[  const { something } = await request.json();]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[  return json({ something }, { status: 200, headers });]]
  page_content[#page_content + 1] = [[};]]
  vim.fn.mkdir('src/routes/api/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

function SvelteKitNewAPIGet(pagename)
  local page_path = 'src/routes/api/' .. pagename .. '/+server.ts'
  local page_content = {}
  page_content[#page_content + 1] = [[import { json } from "@sveltejs/kit";]]
  page_content[#page_content + 1] = [[import type { RequestHandler } from "./$types";]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[const headers = {]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Origin": "*",]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Methods": "GET,HEAD,PUT,PATCH,POST,DELETE",]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Headers": "Content-Type,authorization",]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const OPTIONS: RequestHandler = () => {]]
  page_content[#page_content + 1] = [[  return new Response("", {]]
  page_content[#page_content + 1] = [[    status: 200,]]
  page_content[#page_content + 1] = [[    headers,]]
  page_content[#page_content + 1] = [[  });]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const GET: RequestHandler = ({ url, params }) => {]]
  page_content[#page_content + 1] = [[  const q = url.searchParams.get("q");]]
  page_content[#page_content + 1] = [[  // const slug = params.slug;]]
  page_content[#page_content + 1] = [[  const number = Math.floor(Math.random() * 6) + 1;]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[  return json({ number }, {status:200, headers});]]
  page_content[#page_content + 1] = [[};]]
  vim.fn.mkdir('src/routes/api/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

-- NPM
function Npm_install()
  local package_lock_exists = vim.fn.filereadable 'package-lock.json' == 1
  local yarn_lock_exists = vim.fn.filereadable 'yarn.lock' == 1
  local pnpm_lock_exists = vim.fn.filereadable 'pnpm-lock.yaml' == 1
  if package_lock_exists then
    RunCommandInNewTab 'npm install --legacy-peer-deps'
  elseif yarn_lock_exists then
    RunCommandInNewTab 'yarn'
  elseif pnpm_lock_exists then
    RunCommandInNewTab 'pnpm install'
  else
    RunCommandInNewTab 'npm install --legacy-peer-deps'
  end
end

function GetFileType()
  local filename = vim.fn.expand '%:t'
  local extension = vim.fn.fnamemodify(filename, ':e')

  if extension == 'js' or extension == 'jsx' then
    return 'javascript'
  elseif extension == 'ts' or extension == 'tsx' then
    return 'typescript'
  elseif extension == 'cpp' or extension == 'c' then
    return 'cpp'
  elseif extension == 'sh' then
    return 'shell'
  else
    return 'unknown'
  end
end

function fileExists(fileName)
  local file = io.open(fileName, 'r')
  if file then
    file:close()
    return true
  else
    return false
  end
end

function BuildAndNotify()
  vim.notify('Building Project...', vim.log.levels.INFO, {
    title = 'NPM',
    timeout = 36000000,
  })

  vim.fn.jobstart('npm run build', {
    on_stdout = function(id, data, e)
      notif(id, data, e, 4000)
    end,
    on_stderr = function(id, data, e)
      notif(id, data, e, 4000)
    end,
    on_exit = function(id, data, e)
      notif(id, data, e, 4000)
    end,
  })
end

function RunCommandInNewTab(command)
  vim.cmd(':-1tabnew | te  ' .. command)
end

function RunCommandAndNotify(command, timeout, title)
  if timeout == nil then
    timeout = 36000000
  end
  if title == nil then
    title = 'Run Command'
  end
  vim.notify(title, vim.log.levels.INFO, {
    title = title,
    timeout = timeout,
  })

  vim.fn.jobstart(command, {
    on_stdout = function(id, data, e)
      -- notif(id, data, e, 4000)
    end,
    on_stderr = function(id, data, e)
      -- notif(id, data, e, 4000)
    end,
    on_exit = function(id, data, e)
      notif(id, data, e, 4000)
    end,
  })
end

return {}
