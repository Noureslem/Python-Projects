def hanoi_solver(n):
    rods = {
        'A': list(range(n, 0, -1)),
        'B': [],
        'C': []
    }

    moves = []
    moves.append(format_rods(rods))

    def move_disks(n, source, auxiliary, destination):
        if n == 0:
            return
        move_disks(n - 1, source, destination, auxiliary)
        disk = rods[source].pop()
        rods[destination].append(disk)
        moves.append(format_rods(rods))
        move_disks(n - 1, auxiliary, source, destination)

    def format_rods(rods):
        return f"{rods['A']} {rods['B']} {rods['C']}"

    move_disks(n, 'A', 'B', 'C')

    return "\n".join(moves)
