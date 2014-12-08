# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/appdata-tools/appdata-tools-0.1.8-r1.ebuild,v 1.4 2014/12/08 13:16:14 pacho Exp $

EAPI=5

DESCRIPTION="CLI designed to validate AppData descriptions for standards compliance and to the style guide"
HOMEPAGE="https://github.com/hughsie/appdata-tools/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

# Superseeded by appstream-glib.
RDEPEND=">=dev-libs/appstream-glib-0.3.2"
