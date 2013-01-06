# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.0.27-r1.ebuild,v 1.6 2008/12/14 20:17:13 klausman Exp $

MY_EXTRAS_VER="20070105"
SERVER_URI="mirror://mysql/Downloads/MySQL-${PV%.*}/mysql-${PV//_/-}.tar.gz"

inherit mysql
# only to make repoman happy. it is really set in the eclass
IUSE="$IUSE"

# REMEMBER: also update eclass/mysql*.eclass before committing!
KEYWORDS="amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"

src_test() {
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	make check || die "make check failed"
	if ! use "minimal" ; then
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		local retstatus
		addpredict /this-dir-does-not-exist/t9.MYI

		cd mysql-test
		sed -i -e "s|PORT=3306|PORT=3307|g" mysql-test-run
		./mysql-test-run
		retstatus=$?

		# Just to be sure ;)
		pkill -9 -f "${S}/ndb" 2>/dev/null
		pkill -9 -f "${S}/sql" 2>/dev/null
		[[ $retstatus -eq 0 ]] || die "make test failed"
	else
		einfo "Skipping server tests due to minimal build."
	fi
}
