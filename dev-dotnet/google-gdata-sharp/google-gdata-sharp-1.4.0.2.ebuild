# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/google-gdata-sharp/google-gdata-sharp-1.4.0.2.ebuild,v 1.4 2010/07/12 17:49:04 fauli Exp $

EAPI=3

inherit base mono

MY_PN="libgoogle-data-mono"

DESCRIPTION="C# bindings for the Google GData API"
HOMEPAGE="http://code.google.com/p/google-gdata/"
SRC_URI="http://google-gdata.googlecode.com/files/${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# tests are completely broken (bug #310101), revisit in future bumps.
RESTRICT="test"

DEPEND=">=dev-lang/mono-2.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"
# The Makefile has prefix=/usr/local by default :|
MAKEOPTS="PREFIX=/usr ${MAKEOPTS}"

src_prepare() {
	epatch "${FILESDIR}"/pkgconfig-typo-fix.patch
}
