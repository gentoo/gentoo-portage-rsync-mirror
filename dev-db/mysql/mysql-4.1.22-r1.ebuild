# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.1.22-r1.ebuild,v 1.8 2011/07/08 10:05:34 ssuominen Exp $

MY_EXTRAS_VER="20090228-2228Z"
SERVER_URI="mirror://mysql/Downloads/MySQL-${PV%.*}/mysql-${PV//_/-}.tar.gz"

inherit mysql
# only to make repoman happy. it is really set in the eclass
IUSE="$IUSE"

# REMEMBER: also update eclass/mysql*.eclass before committing!
KEYWORDS="amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

src_test() {
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	make check || die "make check failed"
	if ! use "minimal" ; then
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		local retstatus
		local testopts="--force"

		# sandbox makes ndbd zombie
		has "sandbox" ${FEATURES} && testopts="${testopts} --skip-ndb"

		addpredict /this-dir-does-not-exist/t9.MYI

		cd mysql-test
		sed -i -e "s|3306|3307|g" mysql-test-run.pl

		# from Makefile.am:
		retstatus=1
		./mysql-test-run.pl ${testopts} \
		&& ./mysql-test-run.pl ${testopts} --ps-protocol \
		&& retstatus=0

		# Just to be sure ;)
		pkill -9 -f "${S}/ndb" 2>/dev/null
		pkill -9 -f "${S}/sql" 2>/dev/null
		[[ $retstatus -eq 0 ]] || die "test failed"
	else
		einfo "Skipping server tests due to minimal build."
	fi
}
