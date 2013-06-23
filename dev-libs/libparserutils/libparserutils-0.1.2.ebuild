# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libparserutils/libparserutils-0.1.2.ebuild,v 1.2 2013/06/23 16:42:55 xmw Exp $

EAPI=5

inherit flag-o-matic netsurf

DESCRIPTION="library for building efficient parsers, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libparserutils/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="iconv test"

DEPEND="test? (	dev-lang/perl )"

DOCS=( README docs/Todo )

src_configure() {
	netsurf_src_configure

	append-cflags "-D$(usex iconv WITH WITHOUT)_ICONV_FILTER"
}
