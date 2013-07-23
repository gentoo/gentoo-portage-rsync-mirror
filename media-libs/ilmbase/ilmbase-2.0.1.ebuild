# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ilmbase/ilmbase-2.0.1.ebuild,v 1.2 2013/07/23 16:54:10 ssuominen Exp $

EAPI=5
inherit eutils libtool

DESCRIPTION="OpenEXR ILM Base libraries"
HOMEPAGE="http://openexr.com/"
SRC_URI="http://download.savannah.gnu.org/releases/openexr/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/2.0.1" # 2.0.1 for the namespace off -> on switch, caused library renaming
KEYWORDS="~alpha ~amd64 -arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="static-libs"

src_prepare() {
	elibtoolize
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
	prune_libtool_files
}
