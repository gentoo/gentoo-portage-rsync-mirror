# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/appdata-tools/appdata-tools-0.1.8-r1.ebuild,v 1.1 2014/11/23 22:57:13 eva Exp $

EAPI=5

DESCRIPTION="CLI designed to validate AppData descriptions for standards compliance and to the style guide"
HOMEPAGE="https://github.com/hughsie/appdata-tools/"
SRC_URI="https://github.com/hughsie/${PN}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64"
IUSE=""

# Superseeded by appstream-glib.
DEPEND=">=dev-libs/appstream-glib-0.3.2"
RDEPEND=""
