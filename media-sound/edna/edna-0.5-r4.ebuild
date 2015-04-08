# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/edna/edna-0.5-r4.ebuild,v 1.17 2015/03/21 17:42:37 jlec Exp $

inherit eutils multilib

DESCRIPTION="Greg Stein's python streaming audio server for desktop or LAN use"
HOMEPAGE="http://edna.sourceforge.net/"
SRC_URI="mirror://sourceforge/edna/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 sparc x86"
IUSE="vorbis"

RDEPEND=">=dev-lang/python-2.5
	vorbis? ( dev-python/pyogg
		dev-python/pyvorbis )"
DEPEND="${RDEPEND}"

src_install() {
	newinitd "${FILESDIR}"/edna.gentoo edna

	newbin edna.py edna
	exeinto /usr/$(get_libdir)/edna
	doexe ezt.py MP3Info.py
	insinto /usr/$(get_libdir)/edna/templates
	doins templates/*

	insinto /etc/edna
	doins edna.conf
	dosym /usr/$(get_libdir)/edna/templates /etc/edna/templates

	dodoc README ChangeLog
	dohtml -r www/*
}

pkg_postinst() {
	elog "Edit edna.conf to taste before starting (multiple source"
	elog "directories are allowed).  Test edna from a shell prompt"
	elog "until you have it configured properly, then add edna to"
	elog "the default runlevel when you're ready.  Add the USE flag"
	elog "vorbis if you want edna to serve ogg files."
	elog "See edna.conf and the html docs for more info, and set"
	elog "PYTHONPATH=/usr/lib/edna to run from a shell prompt."
}
