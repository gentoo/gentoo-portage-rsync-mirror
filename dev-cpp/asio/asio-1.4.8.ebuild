# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/asio/asio-1.4.8.ebuild,v 1.2 2012/08/05 20:43:14 blueness Exp $

EAPI=4

DESCRIPTION="Asynchronous Network Library"
HOMEPAGE="http://asio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc examples ssl test"

RDEPEND="ssl? ( dev-libs/openssl )
	>=dev-libs/boost-1.35.0"
DEPEND="${RDEPEND}"

src_prepare() {
	if ! use test; then
		# Don't build nor install any examples or unittests
		# since we don't have a script to run them
		cat > src/Makefile.in <<-EOF
all:

install:
		EOF
	fi
}

src_install() {
	default

	if use doc; then
		dohtml -r doc/*
	fi

	if use examples; then
		if use test; then
			# Get rid of the object files
			emake clean
		fi
		dodoc -r src/examples
	fi
}
