# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ppcre/cl-ppcre-1.2.16.ebuild,v 1.3 2014/07/11 08:47:28 patrick Exp $

inherit common-lisp

DESCRIPTION="CL-PPCRE is a portable regular expression library for Common Lisp."
HOMEPAGE="http://weitz.de/cl-ppcre/
	http://www.cliki.net/cl-ppcre"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
KEYWORDS="amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"
SLOT="0"

CLPACKAGE=cl-ppcre

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc CHANGELOG README doc/benchmarks.2002-12-22.txt
	dohtml doc/index.html
}
