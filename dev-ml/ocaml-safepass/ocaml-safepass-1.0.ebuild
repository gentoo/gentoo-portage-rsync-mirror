# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-safepass/ocaml-safepass-1.0.ebuild,v 1.1 2012/07/20 00:01:52 aballier Exp $

EAPI=4

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="A library offering facilities for the safe storage of user passwords"
HOMEPAGE="http://ocaml-safepass.forge.ocamlcore.org/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/926/${P}.tgz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( "README" "CHANGELOG" )
