# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lohit-nepali/lohit-nepali-2.94.0.ebuild,v 1.1 2015/02/20 18:27:31 yngwin Exp $

EAPI=5
inherit font
FONTDIR="/usr/share/fonts/indic/${PN}"
FONT_SUFFIX="ttf"

DESCRIPTION="The Lohit Nepali font"
HOMEPAGE="https://fedorahosted.org/lohit"
SRC_URI="https://fedorahosted.org/releases/l/o/lohit/${PN}-${FONT_SUFFIX}-${PV}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="!<media-fonts/lohit-fonts-2.20150220"
RDEPEND="${DEPEND}"

RESTRICT="test binchecks"
S=${WORKDIR}/${PN}-${FONT_SUFFIX}-${PV}
FONT_S=${S}
FONT_CONF=( "65-0-${PN}.conf" )
