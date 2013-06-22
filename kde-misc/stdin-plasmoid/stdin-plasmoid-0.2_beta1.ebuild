# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/stdin-plasmoid/stdin-plasmoid-0.2_beta1.ebuild,v 1.1 2013/06/22 21:44:42 creffett Exp $

EAPI=5

inherit kde4-base versionator

MY_P="$(replace_version_separator 2 '-')"

DESCRIPTION="KDE4 plasmoid for executing a process and capturing its stderr and stdout."
HOMEPAGE="http://www.kde-look.org/content/show.php/STDIN+Plasmoid?content=92309"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/92309-${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${MY_P}"
