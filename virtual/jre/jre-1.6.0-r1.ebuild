# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.6.0-r1.ebuild,v 1.2 2014/05/30 11:20:59 tomwij Exp $

EAPI="5"

DESCRIPTION="Virtual for Java Runtime Environment (JRE)"
SLOT="1.6"
KEYWORDS="amd64 ~arm ~ia64 ppc ppc64 x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~hppa-hpux ~ia64-hpux ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"

RDEPEND="|| (
		=virtual/jdk-1.6.0*
		=dev-java/ibm-jre-bin-1.6.0*
		=dev-java/diablo-jre-bin-1.6.0*
	)"
DEPEND=""
