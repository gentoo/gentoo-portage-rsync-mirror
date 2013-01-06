# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pa_ounit/pa_ounit-108.00.01.ebuild,v 1.1 2012/06/30 14:35:38 aballier Exp $

EAPI="4"

inherit oasis

DESCRIPTION="Syntax extension that helps writing in-line test in ocaml"
HOMEPAGE="http://bitbucket.org/yminsky/ocaml-core/wiki/Home"
SRC_URI="http://bitbucket.org/yminsky/ocaml-core/downloads/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-ml/type-conv-3.0.5"
RDEPEND="${DEPEND}"

DOCS=( "readme.md" )
