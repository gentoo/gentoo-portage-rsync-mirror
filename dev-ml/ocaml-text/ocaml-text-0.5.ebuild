# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-text/ocaml-text-0.5.ebuild,v 1.1 2012/03/28 11:37:13 aballier Exp $

EAPI=3

OASIS_BUILD_DOCS=1
inherit oasis

DESCRIPTION="library for dealing with 'text'"
HOMEPAGE="http://forge.ocamlcore.org/projects/ocaml-text/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/641/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pcre"

DEPEND="virtual/libiconv
	pcre? ( dev-ml/pcre-ocaml[ocamlopt?] )"
RDEPEND="${DEPEND}"

src_configure() {
	oasis_configure_opts="$(use_enable pcre)" \
		oasis_src_configure
}
