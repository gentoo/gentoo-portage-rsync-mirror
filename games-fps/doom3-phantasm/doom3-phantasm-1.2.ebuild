# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-phantasm/doom3-phantasm-1.2.ebuild,v 1.5 2014/04/18 17:06:21 ulm Exp $

EAPI=2

MOD_DESC="single-player short mod based on the Phantasm horror movies"
MOD_NAME="Phantasm"
MOD_DIR="phantasm"

inherit games games-mods

HOMEPAGE="http://www.freewebs.com/bladeghost_j/
	http://doom3.filefront.com/file/Phantasm_D3;72040"
SRC_URI="mirror://filefront/Doom_III/Mods/Addons/phantasm_d3_${PV}.zip
	ftp://files.mhgaming.com/doom3/mods/phantasm_d3_${PV}.zip"

LICENSE="all-rights-reserved"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

src_prepare() {
	# Remove useless "_d3" from directory name
	mv -f ${MOD_DIR}_d3 ${MOD_DIR} || die

	# Oh no, a filename containing a space! Gives Portage the heebee-jeebies:
	# * checking 8 files for package collisions
	# existing file /usr/share/games/doom3/phantasm/
	# phantasm_d3_1.2  readme.txt is not owned by this package
	mv -f ${MOD_DIR}/phantasm*.txt ${MOD_DIR}/README.phantasm.txt || die
}
