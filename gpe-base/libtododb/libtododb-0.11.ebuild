# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libtododb/libtododb-0.11.ebuild,v 1.4 2010/05/26 12:23:35 miknix Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe autotools

DESCRIPTION="Database access library for GPE to-do list"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="doc"
GPE_DOCS="ChangeLog"
GPECONF="${GPECONF} $(use_enable doc gtk-doc)"

RDEPEND="${RDEPEND}
	>=gpe-base/libgpewidget-0.113
	>=gpe-base/libgpepimc-0.6
	=dev-db/sqlite-2.8*"

DEPEND="${DEPEND}
	${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.2 )
	dev-util/gtk-doc-am"

src_unpack() {
	gpe_src_unpack "$@"

	# Build ignores --disable-gtk-doc
	# See http://lists.linuxtogo.org/pipermail/gpe-list/2009-July/001018.html
	if ! use doc; then
		sed -i -e 's;SUBDIRS = doc;SUBDIRS = ;' Makefile.am \
		|| die "sed failed"
	fi

	eautoreconf
}

src_compile() {
	# Parallel make only fails when building doc, see #320029 .
	if use doc; then
		export MAKEOPTS="$(echo "$MAKEOPTS" | sed -e "s/-j[0-9]*/-j1/g")"
	fi
	gpe_src_compile "$@"
}
