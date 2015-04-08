# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/takao-fonts/takao-fonts-003.01.20100214.1.ebuild,v 1.1 2010/02/16 15:38:14 matsuu Exp $

inherit font

MY_P="${PN}-otf-${PV}"
DESCRIPTION="A community developed derivatives of IPA Fonts"
HOMEPAGE="https://launchpad.net/takao-fonts"
SRC_URI="http://launchpad.net/${PN}/003.01/${PV}/+download/${MY_P}.tar.gz"

LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"
FONT_SUFFIX="otf"
FONT_S="${S}"

DOCS="ChangeLog README*"

# Only installs fonts
RESTRICT="strip binchecks"
