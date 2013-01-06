# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arkpandora/arkpandora-2.04.ebuild,v 1.15 2009/07/06 21:26:12 jer Exp $

inherit font

IUSE=""

MY_P="ttf-${P}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Arkpandora MS-TTF replacement font pack"
HOMEPAGE="http://www.users.bigpond.net.au/gavindi/"
SRC_URI="http://www.users.bigpond.net.au/gavindi/${MY_P}.tgz"

LICENSE="BitstreamVera"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

FONT_S="${S}"
FONT_SUFFIX="ttf"

DOCS="CHANGELOG.TXT COPYRIGHT.TXT local.conf.arkpandora"
