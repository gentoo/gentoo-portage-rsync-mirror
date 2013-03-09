# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmetalink/libmetalink-0.1.0.ebuild,v 1.7 2013/03/09 18:16:54 jer Exp $

EAPI="2"

inherit base

DESCRIPTION="Library for handling Metalink files"
HOMEPAGE="http://launchpad.net/libmetalink"
SRC_URI="https://launchpad.net/${PN}/trunk/${P}/+download/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ppc64 x86"
IUSE="expat test"

RDEPEND="expat? ( dev-libs/expat )
	!expat? ( >=dev-libs/libxml2-2.6.24 )"
DEPEND="${RDEPEND}
	test? ( dev-util/cunit )"

src_configure() {
	local xml_args
	use expat \
		&& xml_args=--with-libexpat \
		|| xml_args=--with-libxml2

	econf ${xml_args} --docdir=/usr/share/doc/${PF}
}
