# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/r10k/r10k-1.1.0.ebuild,v 1.1 2013/10/07 19:40:59 vikraman Exp $

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

ruby_add_bdepend "test? ( =dev-ruby/rspec-2.14* )"

ruby_add_rdepend "
	>=dev-ruby/colored-1.2
	=dev-ruby/cri-2.4*
	>=dev-ruby/systemu-2.5.2
	<dev-ruby/systemu-2.6.0
	>=dev-ruby/log4r-1.1.10
	dev-ruby/json"

all_ruby_prepare() {
	sed -i 's/json_pure/json/' "${WORKDIR}/all/metadata" || die "metadata fix failed"
}
