# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/metasploit/metasploit-9999.ebuild,v 1.4 2012/10/16 20:05:36 zerochaos Exp $

EAPI="3"
inherit eutils subversion

ESVN_REPO_URI="https://metasploit.com/svn/framework3/trunk"

DESCRIPTION="Advanced open-source framework for developing, testing, and using vulnerability exploit code"
HOMEPAGE="http://www.metasploit.org/"

LICENSE="BSD"
SLOT="4.0"
KEYWORDS=""
IUSE="gui mysql postgres"

# Note we use bundled gems (see data/msfweb/vendor/rails/) as upstream voted for
# such solution, bug #247787
RDEPEND="dev-lang/ruby
	dev-ruby/rubygems
	dev-ruby/kissfft
	gui? ( virtual/jre )
	mysql? ( dev-ruby/mysql-ruby
		dev-ruby/activerecord[mysql] )
	postgres? ( dev-ruby/postgres
		dev-ruby/activerecord[postgres] )"
DEPEND=""

QA_PRESTRIPPED="
	usr/lib/${PN}${SLOT}/data/msflinker_linux_x86.bin
	usr/lib/${PN}${SLOT}/data/templates/template_armle_linux.bin
	usr/lib/${PN}${SLOT}/data/templates/template_x86_linux.bin"

QA_EXECSTACK="
	usr/lib/${PN}${SLOT}/data/meterpreter/msflinker_linux_x86.bin"
QA_WX_LOAD="
	usr/lib/${PN}${SLOT}/data/templates/template_*_linux.bin"

S=${WORKDIR}/msf3

src_unpack() {
	subversion_fetch
}

src_configure() {
	[[ "${ESVN_REVISION}" == "" ]] \
		&& find "${S}" -type d -name ".svn" -print0 | xargs -0 -n1 rm -R

	rm "${S}"/msfupdate
	chmod +x "${S}"/msf*

	use gui || rm msfgui
}

src_install() {
	# should be as simple as copying everything into the target...
	dodir /usr/lib/${PN}${SLOT}
	cp -R "${S}"/* "${D}"/usr/lib/${PN}${SLOT}
	chown -R root:0 "${D}"

	# do not remove LICENSE, bug #238137
	dodir /usr/share/doc/${PF}
	cp "${S}"/{README,HACKING} "${D}"/usr/share/doc/${PF}
	dosym /usr/lib/${PN}${SLOT}/documentation /usr/share/doc/${PF}/documentation

	dodir /usr/bin/
	for file in msf*; do
		dosym /usr/lib/${PN}${SLOT}/${file} /usr/bin/${file}${SLOT}
	done

	newinitd "${FILESDIR}"/msfrpcd-${SLOT}-initd msfrpcd${SLOT} || die
	newconfd "${FILESDIR}"/msfrpcd-${SLOT}-conf msfrpcd${SLOT} || die

	use gui &&	make_desktop_entry msfgui${SLOT} \
			"Metasploit Framework" \
			metasploit \
			'GNOME;System;Network;' &&
		doicon "${FILESDIR}"/metasploit.icon
}

pkg_postinst() {
	if use gui; then
		elog "You will need to create a /usr/bin/msfrpcd symlink pointing to"
		elog "the version of msfrpcd if you want to be able to start msfrpcd"
		elog "from the java gui."
		elog
		elog "ln /usr/bin/msfrpcd${SLOT} /usr/bin/msfrpcd"
		elog
	fi

	elog "If you wish to update ${PN} manually simply run:"
	elog
	elog "ESVN_REVISION=<rev> emerge =${PF}"
	elog
	elog "where <rev> is either HEAD (in case you wish to get all updates)"
	elog "or specific revision number. But NOTE, this update will vanish"
	elog "next time you reemerge ${PN}. To make update permanent either"
	elog "create ebuild with specific revision number inside your overlay"
	elog "or report revision bump bug at http://bugs.gentoo.org ."
	elog
	elog "In case you use portage it's also possible to create"
	elog "/etc/portage/env/${CATEGORY}/${PN} file with ESVN_REVISION=<rev>"
	elog "content. Then each time you run emerge ${PN} you'll have said"
	elog "<rev> installed. For example, if you run"
	elog " # mkdir -p /etc/portage/env/${CATEGORY}"
	elog " # echo ESVN_REVISION=HEAD >> /etc/portage/env/${CATEGORY}/${PN}"
	elog "each time you reemerge ${PN} it'll be updated to get all possible"
	elog "updates for framework-${PV%_p*} branch."
}
