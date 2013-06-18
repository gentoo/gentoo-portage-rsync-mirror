# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/drop2ftp/drop2ftp-0.6.ebuild,v 1.1 2013/06/17 23:03:09 creffett Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE4 plasmoid. Add files over KIO supported protocols, like ftp and ssh."
HOMEPAGE="http://www.kde-look.org/content/show.php/Drop2FTP?content=97281"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/97281-${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
"

PATCHES=( "${FILESDIR}/${P}-qt47.patch" )
