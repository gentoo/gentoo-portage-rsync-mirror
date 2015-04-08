# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/aclock/aclock-0.3.ebuild,v 1.1 2009/04/07 14:01:34 voyageur Exp $

inherit gnustep-2

DESCRIPTION="Analog dockapp clock for GNUstep"
HOMEPAGE="http://gnu.ethz.ch/linuks.mine.nu/aclock/"
SRC_URI="http://gnu.ethz.ch/linuks.mine.nu/aclock/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

gnustep_config_script() {
	echo "echo ' * using smooth seconds'"
	echo "defaults write AClock SmoothSeconds YES"
	echo "echo ' * setting refresh rate to 0.1 seconds'"
	echo "defaults write AClock RefreshRate 0.1"
}
