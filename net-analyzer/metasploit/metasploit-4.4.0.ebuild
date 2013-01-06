# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/metasploit/metasploit-4.4.0.ebuild,v 1.2 2012/08/25 00:37:21 mr_bones_ Exp $

EAPI="3"
inherit eutils multilib

SRC_URI="http://updates.metasploit.com/data/releases/framework-${PV}.tar.bz2"

DESCRIPTION="Advanced open-source framework for developing, testing, and using vulnerability exploit code"
HOMEPAGE="http://www.metasploit.org/"

LICENSE="BSD"
SLOT="4.4"
KEYWORDS="~amd64 ~x86"
IUSE="gui mysql postgres"

# Note we use bundled gems (see data/msfweb/vendor/rails/) as upstream voted for
# such solution, bug #247787
RDEPEND="dev-lang/ruby
	dev-ruby/rubygems
	dev-ruby/msgpack
	gui? ( virtual/jre )
	mysql? ( dev-ruby/mysql-ruby
		dev-ruby/activerecord[mysql] )
	postgres? ( dev-ruby/postgres
		dev-ruby/activerecord[postgres] )"
DEPEND=""

QA_PREBUILT="
	usr/$(get_libdir)/${PN}${SLOT}/data/cpuinfo/cpuinfo.ia32.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/cpuinfo/cpuinfo.ia64.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_armle_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_solaris.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x64_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_bsd.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/msflinker_linux_x86.bin
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux64/eventmachine-0.12.10/lib/fastfilereaderext.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux64/eventmachine-0.12.10/lib/rubyeventmachine.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux64/thin-1.3.1/lib/thin_parser.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux64/nokogiri-1.5.2/lib/nokogiri/nokogiri.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux64/pg-0.13.2/lib/pg_ext.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux64/msgpack-0.4.6/lib/msgpack.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux32/eventmachine-0.12.10/lib/fastfilereaderext.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux32/eventmachine-0.12.10/lib/rubyeventmachine.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux32/thin-1.3.1/lib/thin_parser.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux32/nokogiri-1.5.2/lib/nokogiri/nokogiri.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux32/pg-0.13.2/lib/pg_ext.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch/linux32/msgpack-0.4.6/lib/msgpack.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch-old/linux64/pg-0.13.2/lib/pg_ext.so
	usr/$(get_libdir)/${PN}${SLOT}/lib/gemcache/ruby/1.9.1/arch-old/linux32/pg-0.13.2/lib/pg_ext.so
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.sse2/john
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.sse2/genmkvpwd
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.sse2/tgtsnarf
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.sse2/mkvcalcproba
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.sse2/calc_stat
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x64.mmx/john
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x64.mmx/genmkvpwd
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x64.mmx/tgtsnarf
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x64.mmx/mkvcalcproba
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x64.mmx/calc_stat
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/john
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/genmkvpwd
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/tgtsnarf
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/mkvcalcproba
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/calc_stat
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.mmx/john
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.mmx/genmkvpwd
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.mmx/tgtsnarf
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.mmx/mkvcalcproba
	usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.mmx/calc_stat
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/ext_server_sniffer.lso
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/ext_server_networkpug.lso
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/ext_server_stdapi.lso"

S=${WORKDIR}/msf3

src_configure() {
	# upstream makes weird tarbllz
	find "${S}" -type d -name ".svn" -print0 | xargs -0 -n1 rm -R

	rm "${S}"/msfupdate
	chmod +x "${S}"/msf*

	use gui || rm msfgui
}

src_install() {
	# should be as simple as copying everything into the target...
	dodir /usr/$(get_libdir)/${PN}${SLOT}
	cp -R "${S}"/* "${D}"/usr/$(get_libdir)/${PN}${SLOT}
	chown -R root:0 "${D}"

	# do not remove LICENSE, bug #238137
	dodir /usr/share/doc/${PF}
	cp "${S}"/{README,HACKING} "${D}"/usr/share/doc/${PF}
	dosym /usr/$(get_libdir)/${PN}${SLOT}/documentation /usr/share/doc/${PF}/documentation

	dodir /usr/bin/
	for file in msf*; do
		dosym /usr/$(get_libdir)/${PN}${SLOT}/${file} /usr/bin/${file}${SLOT}
	done

	newinitd "${FILESDIR}"/msfrpcd-${SLOT}-initd msfrpcd${SLOT} || die
	newconfd "${FILESDIR}"/msfrpcd-${SLOT}-conf msfrpcd${SLOT} || die

	use gui &&	make_desktop_entry msfgui${SLOT} \
			"Metasploit Framework" \
			metasploit \
			'GNOME;System;Network;GTK;' &&
		doicon "${FILESDIR}"/metasploit.icon

	# Avoid useless revdep-rebuild trigger #377617
	dodir /etc/revdep-rebuild/
	echo "SEARCH_DIRS_MASK=\"/usr/lib*/${PN}${SLOT}/data/john\"" > \
		"${D}"/etc/revdep-rebuild/70-${PN}-${SLOT}
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
}
