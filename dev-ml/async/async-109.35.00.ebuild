# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/async/async-109.35.00.ebuild,v 1.1 2013/08/01 14:54:45 aballier Exp $

EAPI="5"

OASIS_BUILD_DOCS=1
OASIS_BUILD_TESTS=1

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Jane Street Capital's asynchronous execution library"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${MY_P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND=">=dev-lang/ocaml-4.00.0:=
	>=dev-ml/async_core-${PV}:=
	>=dev-ml/async_unix-${PV}:=
	>=dev-ml/async_extra-${PV}:=
	"
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.0.2 )"

S="${WORKDIR}/${MY_P}"

src_install() {
	oasis_src_install
	if use examples ; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
