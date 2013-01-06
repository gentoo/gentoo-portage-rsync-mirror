# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hyperestraier/hyperestraier-1.4.10-r1.ebuild,v 1.7 2012/06/03 23:24:09 zmedico Exp $

inherit java-pkg-opt-2 multilib

IUSE="debug java mecab ruby"

DESCRIPTION="a full-text search system for communities"
HOMEPAGE="http://fallabs.com/hyperestraier/"
SRC_URI="http://fallabs.com/hyperestraier/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="amd64 ppc sparc x86"
SLOT="0"

RDEPEND=">=dev-db/qdbm-1.8.75
	sys-libs/zlib
	java? ( >=virtual/jre-1.4 )
	mecab? ( app-text/mecab )
	ruby? ( dev-lang/ruby )"
DEPEND="${RDEPEND}
	java? ( >=virtual/jdk-1.4 )"

src_unpack() {

	unpack ${A}
	cd "${S}"

	# fix for insecure runpath warning.
	sed -i "/^LDENV/d" Makefile.in

	sed -i "/^JAVACFLAGS/s:$: ${JAVACFLAGS}:" java*/Makefile.in

}

src_compile() {

	econf \
		`use_enable debug` \
		`use_enable mecab` \
		|| die
	emake || die

	local u d

	for u in java ruby; do
		if ! use ${u}; then
			continue
		fi

		for d in ${u}native ${u}pure; do
			cd ${d}
			econf || die
			emake || die
			cd -
		done
	done

}

src_test() {

	emake -j1 check || die

	local u d

	for u in java ruby; do
		if ! use ${u}; then
			continue
		fi

		for d in ${u}native; do
			cd ${d}
			emake -j1 check || die
			cd -
		done
	done

}

src_install() {

	emake DESTDIR="${D}" MYDOCS= install || die
	dodoc ChangeLog README* THANKS
	dohtml doc/*

	local u d

	for u in java ruby; do
		if ! use ${u}; then
			continue
		fi

		for d in ${u}native ${u}pure; do
			cd ${d}
			emake DESTDIR="${D}" install || die
			cd -
			dohtml -r doc/${d}api
		done
	done

	if use java; then
		java-pkg_dojar "${D}"/usr/$(get_libdir)/*.jar
		rm -f "${D}"/usr/$(get_libdir)/*.jar
	fi

	rm -f "${D}"/usr/bin/*test

}
