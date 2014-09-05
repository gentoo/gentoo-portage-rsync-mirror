# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/megatools/megatools-1.9.92.ebuild,v 1.1 2014/09/05 07:12:44 dlan Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils

DESCRIPTION="Command line tools and C library for accessing Mega cloud storage"
HOMEPAGE="https://github.com/megous/megatools"
SRC_URI="https://github.com/megous/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="introspection doc"

DEPEND="dev-libs/glib:2
	dev-libs/openssl
	net-misc/curl
	sys-fs/fuse
	doc? ( app-text/asciidoc )
"
RDEPEND="${DEPEND}"

src_configure() {
	local myeconfargs=(
		--enable-shared
		--disable-maintainer-mode
		--disable-warnings
		--disable-static
		--disable-glibtest
		$(use_enable introspection)
		$(use_enable doc docs-build)
	)
	autotools-utils_src_configure
}
