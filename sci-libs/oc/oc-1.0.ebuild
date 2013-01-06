# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/oc/oc-1.0.ebuild,v 1.1 2009/12/12 18:12:31 bicatali Exp $

EAPI=2
inherit eutils

DESCRIPTION="Network Data Access Protocol client C library"
HOMEPAGE="http://opendap.org/"
SRC_URI="http://opendap.org/pub/OC/source/${P}.tar.gz"

LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog NEWS
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins *.html || die
	fi
}
