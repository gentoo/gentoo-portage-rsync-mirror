# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libmimedir/libmimedir-0.4.2.ebuild,v 1.4 2009/07/16 00:44:29 mr_bones_ Exp $

GPE_TARBALL_SUFFIX="gz"
GPE_MIRROR="http://gpe.linuxtogo.org/download/source"

inherit gpe autotools

DESCRIPTION="RFC2425 MIME Directory Profile library"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE} doc"
GPE_DOCS="AUTHORS ChangeLog COPYING.LIB INSTALL NEWS README TODO"
GPECONF="$(use_enable doc gtk-doc)"

RDEPEND="${RDEPEND}
	!dev-libs/libmimedir
	>=gpe-base/libgpewidget-0.102"

DEPEND="${DEPEND}
	${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )"

src_unpack() {
	gpe_src_unpack "$@"

	if ! use doc; then
		sed -i -e 's;docs;;' Makefile.am \
		|| die "sed failed"
	fi

	eautoreconf
}
