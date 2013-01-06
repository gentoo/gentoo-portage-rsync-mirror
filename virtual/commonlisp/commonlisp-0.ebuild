# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/commonlisp/commonlisp-0.ebuild,v 1.2 2012/06/20 07:07:09 ssuominen Exp $

DESCRIPTION="Virtual for Common Lisp"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~sparc x86"
IUSE=""

RDEPEND="|| ( dev-lisp/sbcl
	dev-lisp/clisp
	dev-lisp/clozurecl
	dev-lisp/cmucl
	dev-lisp/ecls
	dev-lisp/openmcl )"
