# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/zinnia/zinnia-0.06-r2.ebuild,v 1.2 2013/09/10 08:33:50 idella4 Exp $

EAPI=5

inherit perl-module eutils flag-o-matic toolchain-funcs autotools

DESCRIPTION="Online hand recognition system with machine learning"
HOMEPAGE="http://zinnia.sourceforge.net/"
SRC_URI="mirror://sourceforge/zinnia/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Package warrants IUSE doc
IUSE="perl"
DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	epatch "${FILESDIR}/${P}-ricedown.patch"
	epatch "${FILESDIR}/${P}-perl.patch"
	eautoreconf

	if use perl ; then
		(
			cd "${S}/perl"
			perl-module_src_prepare
		)
	fi
}

src_configure() {
	econf
}

src_compile() {
	base_src_compile

	if use perl ; then
		(
			cd "${S}/perl"

			# We need to run this here as otherwise it won't pick up the
			# just-built -lzinnia and cause the extension to have
			# undefined symbols.
			perl-module_src_configure

			append-cppflags "-I${S}"
			append-ldflags "-L${S}/.libs"

			emake \
				LDDLFLAGS="-shared" \
				OTHERLDFLAGS="${LDFLAGS}" \
				CC="$(tc-getCXX)" LD="$(tc-getCXX)" \
				OPTIMIZE="${CPPFLAGS} ${CXXFLAGS}" \
		)
	fi
}

# no tests present
src_test() { :; }

src_install() {
	emake DESTDIR="${D}" install
	find "${D}" -name '*.la' -delete

	if use perl ; then
		(
			cd "${S}/perl"
			perl-module_src_install
		)
	fi

	# Curiously ChangeLog & NEWS are left uncompressed
	dodoc ${DOCS[@]}
	dohtml doc/*.html doc/*.css
}
