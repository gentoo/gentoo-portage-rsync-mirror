# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/confix/confix-9999.ebuild,v 1.7 2013/11/05 14:29:15 haubi Exp $

EAPI=3
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils subversion

DESCRIPTION="Confix: A Build Tool on Top of GNU Automake"
HOMEPAGE="http://confix.sourceforge.net"
ESVN_REPO_URI="http://svn.code.sf.net/p/confix/svn/confix/trunk"
ESVN_PROJECT="${PN}"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="dev-util/confix-wrapper
	sys-devel/autoconf-archive
	sys-devel/automake
	sys-devel/libtool"

PYTHON_MODNAME="libconfix"

src_prepare() {
	# find jni-include dirs on hpux.
	epatch "${FILESDIR}"/2.1.0/jni-hpux.patch
	# add .exe extension to TESTS
	epatch "${FILESDIR}"/2.3.0/exeext.patch
	# use external autoconf archive
	epatch "${FILESDIR}"/2.3.0/ext-ac-archive.patch
	# link local libraries first.
	epatch "${FILESDIR}"/2.3.0/local-libs-first.patch
	# don't use automake 1.9, but any newer too...
	epatch "${FILESDIR}"/2.3.0/new-automake.patch
}

pkg_preinst() {
	local RV=2.3.0

	if has_version "<dev-util/confix-${RV}"; then
		einfo "After merging ${P} you might have to remerge all packages built"
		einfo "with <dev-util/confix-${RV} in your EPREFIX to get all the"
		einfo "repo files useable with current ${PN}".
		ewarn
		ewarn "Use this command (copy&paste) to identify packages built with confix"
		ewarn "needing a remerge in your particular instance of Gentoo Prefix:"
		ewarn
		# use 'echo' to get this command from here:
		ewarn "( cd \$(portageq envvar EPREFIX)/var/db/pkg || exit 1;" \
			  "pattern=\$(cd ../../.. && echo \$(ls -d" \
			  "usr/share/confix*/repo | grep -v confix-${RV}) |" \
			  "sed -e 's, ,|,g'); if [[ -z \${pattern} ]]; then echo" \
			  "'No more packages were built with broken Confix.'; exit 0;" \
			  "fi; emerge --ask --oneshot \$(grep -lE \"(\${pattern})\"" \
			  "*/*/CONTENTS | sed -e 's,^,>=,;s,/CONTENTS,,')" \
			  ")"
		ewarn
	fi
}
