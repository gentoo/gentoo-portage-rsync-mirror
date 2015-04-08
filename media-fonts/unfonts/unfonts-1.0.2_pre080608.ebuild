# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/unfonts/unfonts-1.0.2_pre080608.ebuild,v 1.8 2009/06/24 13:43:49 armin76 Exp $

inherit font

MY_PN="un-fonts"
MY_PV=${PV/_pre/-}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="Korean Un fonts collection"
HOMEPAGE="http://kldp.net/projects/unfonts/"
SRC_URI="http://kldp.net/frs/download.php/4696/un-fonts-core-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S=${S}

# Only installs fonts
RESTRICT="strip binchecks"
