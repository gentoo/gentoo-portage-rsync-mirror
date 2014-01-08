# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/ocsigen/ocsigen-1.3.4.ebuild,v 1.4 2014/01/08 06:08:46 vapier Exp $

EAPI=2

inherit eutils findlib multilib user

DESCRIPTION="Ocaml-powered webserver and framework for dynamic web programming"
HOMEPAGE="http://www.ocsigen.org"
SRC_URI="http://www.ocsigen.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug ocamlduce doc dbm +ocamlopt sqlite zlib"
RESTRICT="strip installsources"

DEPEND="dev-ml/findlib
		>=dev-ml/lwt-2.0.0_rc
		zlib? ( >=dev-ml/camlzip-1.03-r1 )
		dev-ml/cryptokit
		dev-ml/obrowser
		>=dev-ml/pcre-ocaml-6.0.1
		>=dev-lang/ocaml-3.10.2[ocamlopt?]
		!sqlite? ( !dbm? ( || ( dev-ml/camldbm >=dev-lang/ocaml-3.10.2[gdbm] ) ) )
		>=dev-ml/ocamlnet-2.2
		>=dev-ml/ocaml-ssl-0.4
		ocamlduce? ( >=dev-ml/ocamlduce-3.10.0 )
		!dbm? ( dev-ml/ocaml-sqlite3 )
		sqlite? ( dev-ml/ocaml-sqlite3 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup ocsigen
	enewuser ocsigen -1 -1 /var/www ocsigen

	use !dbm && use !sqlite \
		&& ewarn "Neither dbm nor sqlite are in useflags, will enable sqlite as default"

	use sqlite && use dbm \
		&& ewarn "sqlite and dbm are both in useflags, will use only sqlite"
}

use_enable_default() {
	if use $2; then
		if use $1; then
			echo "--enable-$2  --enable-$1"
		else
			echo "--enable-$2  --disable-$1"
		fi
	else
		echo "--disable-$2  --enable-$1"
	fi
}

has_dynlink() {
	if has_version '>=dev-lang/ocaml-3.11' && use ocamlopt ; then
		echo "--enable-natdynlink"
	else
		echo "--disable-natdynlink"
	fi
}

src_configure() {
	./configure \
		--prefix /usr \
		--temproot "${D}" \
		--bindir /usr/bin \
		--docdir /usr/share/doc \
		--mandir /usr/share/man/man1 \
		--extralibdir /usr/$(get_libdir) \
		--examplesdir /usr/$(get_libdir) \
		$(use_enable debug) \
		$(use_enable ocamlduce) \
		$(use_enable zlib camlzip) \
		$(use_enable_default sqlite dbm) \
		$(use_enable ocamlopt nativecode) \
		$(has_dynlink) \
		--ocsigen-group ocsigen \
		--ocsigen-user ocsigen  \
		--name ocsigen \
		|| die "Error : configure failed!"
}

src_compile() {
	emake -j1 depend || die "Error : make depend failed!"
	emake -j1 || die "Error : make failed!"
}

src_install() {
	if use doc ; then
		emake -j1 install || die "Error : make install failed!"
	else
		emake -j1 installnodoc || die "Error : make install failed!"
	fi

	emake -j1 logrotate || die "Error : make logrotate failed!"

	newinitd "${FILESDIR}"/ocsigen.initd ocsigen || die
	newconfd "${FILESDIR}"/ocsigen.confd ocsigen || die

	dodoc README
}
