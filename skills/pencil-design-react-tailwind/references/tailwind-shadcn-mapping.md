# React/Tailwind Mapping Reference

Use this as a quick reference when the repo follows a semantic utility + reusable component pattern.

## Pencil component to shadcn/ui mapping

| Pencil pattern | React-oriented mapping |
|---|---|
| button | `<Button>` or a repo button variant |
| card | `<Card>` with header/body/footer composition |
| input field | `<Input>` or a shared field wrapper |
| select / dropdown | `<Select>` family |
| badge / pill | `<Badge>` or a shared status chip |
| avatar | `<Avatar>` family |
| dialog | `<Dialog>` family |
| tabs | `<Tabs>` family |
| table row/card row | reusable row component with status and action slots |
| separator | `<Separator>` |
| label | `<Label>` |

If no obvious mapping exists, prefer a custom reusable component using the same conventions as the repo rather than page-local duplicated markup.

## Registry fallback

When the right component is unclear:

1. search the shadcn registry for the functional match
2. inspect available examples
3. use the registry component if it matches the repo’s conventions
4. otherwise build a repo-native reusable component

## Token usage principle

Prefer semantic classes like:

- `bg-primary`
- `text-foreground`
- `border-border`
- `rounded-md`

Avoid raw arbitrary values when semantic tokens already exist.

## Icon mapping

Map generic Material-style Pencil icons to Lucide equivalents when the repo uses Lucide:

| Pencil icon | Lucide |
|---|---|
| `search` | `Search` |
| `close` | `X` |
| `menu` | `Menu` |
| `arrow_forward` | `ArrowRight` |
| `arrow_back` | `ArrowLeft` |
| `settings` | `Settings` |
| `person` | `User` |
| `notifications` | `Bell` |
| `logout` | `LogOut` |

Use size utilities such as `size-4` or `size-5` rather than inline pixel styles where the repo already does that.

## Component principle

If multiple screens use the same pattern, it should likely become or remain a reusable component.

## Anti-patterns

| Wrong | Better |
|---|---|
| `bg-[#3b82f6]` | `bg-primary` |
| `text-[var(--primary)]` | `text-primary` |
| `rounded-[6px]` | `rounded-md` |
| one-off page markup for a repeated card | shared reusable component |
| importing a random icon library for one screen | stay with the repo’s icon system |
