# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-colorschemes/kdeartwork-colorschemes-4.10.4.ebuild,v 1.3 2013/06/30 10:09:46 ago Exp $

EAPI=5

KMNAME="kdeartwork"
KMMODULE="ColorSchemes"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="KDE extra colorschemes"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

# Moved here in 4.7
add_blocker kdeaccessibility-colorschemes
