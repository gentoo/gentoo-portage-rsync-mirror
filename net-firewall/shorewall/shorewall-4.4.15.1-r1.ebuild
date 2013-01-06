# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-4.4.15.1-r1.ebuild,v 1.1 2011/08/06 15:26:11 constanze Exp $

EAPI="2"

inherit eutils versionator

# Select version (stable, RC, Beta):
MY_PV_TREE=$(get_version_component_range 1-2)   # for devel versions use "development/$(get_version_component_range 1-2)"
MY_P_BETA=""                                    # stable or experimental (eg. "-RC1" or "-Beta4")
MY_PV_BASE=$(get_version_component_range 1-3)

MY_P="${PN}-${MY_PV_BASE}${MY_P_BETA}"
MY_P_DOCS="${P/${PN}/${PN}-docs-html}"

DESCRIPTION="Shoreline Firewall is an iptables-based firewall for Linux."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/${PN}/${MY_PV_TREE}/${MY_P}/${P}${MY_P_BETA}.tar.bz2
	doc? ( http://www1.shorewall.net/pub/${PN}/${MY_PV_TREE}/${MY_P}/${MY_P_DOCS}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE="doc"

DEPEND=">=net-firewall/iptables-1.2.4
	sys-apps/iproute2[-minimal]
	dev-lang/perl
	!net-firewall/shorewall-common
	!net-firewall/shorewall-shell
	!net-firewall/shorewall-perl"
RDEPEND="${DEPEND}"

src_prepare() {
	    epatch "${FILESDIR}/all_zone.patch"
		epatch_user
}

src_compile() {
	:;
}

src_install() {
	keepdir /var/lib/shorewall

	cd "${WORKDIR}/${P}${MY_P_BETA}"
	PREFIX="${D}" ./install.sh || die "install.sh failed"
	newinitd "${FILESDIR}"/shorewall.initd shorewall || die "doinitd failed"

	dodoc changelog.txt releasenotes.txt || die

	if use doc; then
		cd "${WORKDIR}/${MY_P_DOCS}"
		# install documentation
		dohtml -r *
		## dosym Documentation_Index.html "/usr/share/doc/${PF}/html/index.htm"
		# install samples
		cp -pR "${S}${MY_P_BETA}/Samples" "${D}/usr/share/doc/${PF}"
	fi
}

pkg_postinst() {
	elog
	if use doc ; then
		elog "Documentation is available at /usr/share/doc/${PF}/html."
		elog "Please read the Release Notes in /usr/share/doc/${PF}."
		elog "Samples are available at /usr/share/doc/${PF}/Samples."
	else
		elog "Documentation is available at http://www.shorewall.net"
	fi
	elog "There are man pages for shorewall(8) and for each configuration file."
	elog
	elog "Bridging configuration has changed with kernel 2.6.20+."
	elog "Check the documentation."
	elog
	elog "Do not blindly start shorewall, edit the files in /etc/shorewall first."
	elog
	elog "Be aware that version ${MY_PV_TREE} differs substantially from previous releases."
	elog "Information on upgrading is available at:"
	elog "http://www.shorewall.net/upgrade_issues.htm"
	elog
	elog "There is a 'shorewall compile' command to generate scripts to run"
	elog "on systems with Shorewall Lite installed."
	elog "Please refer to http://www.shorewall.net/CompiledPrograms.html"
	elog "It is advised to copy the /usr/share/shorewall/configfiles dir to your"
	elog "own 'export directories'. However, whenever you upgrade Shorewall you"
	elog "should check for changes in configfiles and manually update your exports."
	elog "Alternatively, if you only have one Shorewall-Lite system in your network"
	elog "then you can use the configfiles dir but set CONFIG_PROTECT appropriately"
	elog "in /etc/make.conf (man make.conf)."
	elog
	elog "Known problems:"
	elog "http://shorewall.net/pub/${PN}/${MY_PV_TREE}/${MY_P}/known_problems.txt"
	elog
	elog "Whether upgrading or installing you should run shorewall check,"
	elog "correct any errors found and run shorewall restart|start."
	elog
	elog "${PN} now uses Perl only. The shell compiler is obsolete."
	elog "shorewall-common, shorewall-shell and shorewall-perl have been removed."
}
