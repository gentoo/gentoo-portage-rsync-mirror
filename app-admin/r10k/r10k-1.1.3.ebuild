# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/r10k/r10k-1.1.3.ebuild,v 1.1 2014/02/05 02:03:28 vikraman Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Puppet environment and module deployment"
HOMEPAGE="http://github.com/adrienthebo/r10k"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+git"

ruby_add_bdepend "test? ( =dev-ruby/rspec-2.14* )"

ruby_add_rdepend "
	>=dev-ruby/colored-1.2
	=dev-ruby/cri-2.4*
	>=dev-ruby/systemu-2.5.2
	<dev-ruby/systemu-2.6.0
	>=dev-ruby/log4r-1.1.10
	dev-ruby/json"

RDEPEND="${RDEPEND} git? ( >=dev-vcs/git-1.6.6 )"

all_ruby_prepare() {
	sed -i 's/json_pure/json/' "${WORKDIR}/all/metadata" || die "metadata fix failed"
}

pkg_postinst() {
	ewarn
	ewarn "If you are upgrading from 1.1.0 and are using multiple sources, please read"
	ewarn "this. (If not, feel free to continue with your regularly scheduled day.)"
	ewarn
	ewarn "GH-48 (https://github.com/adrienthebo/r10k/issues/48) introduced the ability"
	ewarn "for environments to be prefixed with the source name so that multiple sources"
	ewarn "installed into the same directory would not overwrite each other. However"
	ewarn "prefixing was automatically enabled and would break existing setups where"
	ewarn "multiple sources were cloned into different directories."
	ewarn
	ewarn "Because this introduced a breaking change, SemVer dictates that the automatic"
	ewarn "prefixing has to be rolled back. Prefixing can be enabled but always defaults"
	ewarn "to off. If you are relying on this behavior you will need to update your r10k.yaml"
	ewarn "to enable prefixing on a per-source basis."
	ewarn
	ewarn "Please see the issue (https://github.com/adrienthebo/r10k/issues/48) for more"
	ewarn "information."
}
