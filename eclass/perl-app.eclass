# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-app.eclass,v 1.15 2014/11/02 00:45:43 dilfridge Exp $

# Author: Michael Cummings <mcummings@gentoo.org>
# Maintained by the Perl herd <perl@gentoo.org>

# If the ebuild doesn't override this, ensure we do not depend on the perl subslot value
: ${GENTOO_DEPEND_ON_PERL_SUBSLOT:="no"}
inherit perl-module

perl-app_src_prep() {
	perl-app_src_configure
}

perl-app_src_configure() {
	perl-module_src_configure
}

perl-app_src_compile() {
	has "${EAPI:-0}" 0 1 && perl-app_src_prep
	perl-module_src_compile
}
