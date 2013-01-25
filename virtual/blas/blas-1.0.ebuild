# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/blas/blas-1.0.ebuild,v 1.12 2013/01/25 17:19:25 ottxor Exp $

DESCRIPTION="Virtual for FORTRAN 77 BLAS implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 s390 sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="|| (
		sci-libs/blas-reference
		>=sci-libs/mkl-9.1.023
		sci-libs/acml
		sci-libs/blas-goto
	)"
DEPEND=""
