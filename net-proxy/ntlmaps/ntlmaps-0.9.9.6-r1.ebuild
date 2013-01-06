# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/ntlmaps/ntlmaps-0.9.9.6-r1.ebuild,v 1.2 2010/10/15 21:44:40 arfrever Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils python

DESCRIPTION="NTLM proxy Authentication against MS proxy/web server"
HOMEPAGE="http://ntlmaps.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~x86"
IUSE=""

pkg_setup() {
	python_pkg_setup
	enewgroup ntlmaps
	enewuser ntlmaps -1 -1 -1 ntlmaps
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch"
	python_convert_shebangs 2 main.py

	#stupid windoze style
	cd "${S}"
	sed -i -e 's/\r//' lib/*.py server.cfg doc/*.{txt,htm}
}

src_install() {
	installation() {
		insinto $(python_get_sitedir)
		doins lib/*.py || die
	}
	python_execute_function installation

	pushd lib > /dev/null
	PYTHON_MODULES=(*.py)
	popd > /dev/null

	# exes ------------------------------------------------------------------
	exeinto /usr/bin
	newexe main.py ntlmaps || die "failed to install main program"
	# doc -------------------------------------------------------------------
	dodoc doc/*.txt || die
	dohtml doc/*.{gif,htm} ||die
	# conf ------------------------------------------------------------------
	insopts -m0640 -g ntlmaps
	insinto /etc/ntlmaps
	doins server.cfg
	newinitd "${FILESDIR}/ntlmaps.init" ntlmaps
	# log -------------------------------------------------------------------
	diropts -m 0770 -g ntlmaps
	keepdir /var/log/ntlmaps
}

pkg_postinst() {
	python_mod_optimize "${PYTHON_MODULES[@]}"
}

pkg_postrm() {
	python_mod_cleanup "${PYTHON_MODULES[@]}"
}
