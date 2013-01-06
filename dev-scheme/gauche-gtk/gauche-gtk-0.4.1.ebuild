# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-gtk/gauche-gtk-0.4.1.ebuild,v 1.10 2012/05/03 02:46:49 jdhore Exp $

EAPI=1
inherit eutils flag-o-matic

IUSE="examples glgd nls opengl"

MY_P="${P/g/G}"

DESCRIPTION="GTK2 binding for Gauche"
HOMEPAGE="http://gauche.sf.net/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

LICENSE="BSD"
KEYWORDS="~ppc x86"
SLOT="0"
S=${WORKDIR}/${MY_P}

DEPEND="${RDEPEND}
	virtual/pkgconfig"
RDEPEND="x11-libs/gtk+:2
	>=dev-scheme/gauche-0.7.4.1
	opengl? ( >=x11-libs/gtkglext-0.6.0 )"

src_unpack() {

	unpack ${A}
	cd "${S}"

	if has_version '>=x11-libs/gtk+-2.8'; then
		epatch "${FILESDIR}"/${P}-gtk+-2.8.diff
	fi

}

src_compile() {

	local myconf

	if use opengl; then
		if use glgd; then
			myconf="--enable-glgd"

			if use nls; then
				myconf="${myconf}-pango"
			fi
		else
			myconf="--enable-gtkgl"
		fi
	fi

	strip-flags

	econf ${myconf} || die
	emake || die

}

src_test() {

	return

}

src_install() {

	emake DESTDIR="${D}" install || die

	dodoc ChangeLog README

	if use examples; then
		docinto examples

		for f in examples/*; do
			[ -f ${f} ] && dodoc ${f}
		done

		docinto examples/gtk-tutorial
		dodoc examples/gtk-tutorial/*

		if use opengl; then
			docinto examples/gtkglext
			dodoc examples/gtkglext/*

			if use glgd; then
				docinto examples/glgd
				dodoc examples/glgd/*

				docinto
				newdoc glgd/README README.glgd
				newdoc glgd/README.eucjp README.eucjp.glgd
			fi
		fi
	fi

}

pkg_postinst() {

	if use opengl; then
		elog "If you want to use OpenGL with Gauche, please emerge Gauche-gl."
	fi

}
