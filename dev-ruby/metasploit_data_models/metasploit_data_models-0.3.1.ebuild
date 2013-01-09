# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/metasploit_data_models/metasploit_data_models-0.3.1.ebuild,v 1.2 2013/01/09 04:29:39 zerochaos Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="The database layer for Metasploit"
HOMEPAGE="https://github.com/rapid7/metasploit_data_models"
SRC_URI="https://github.com/rapid7/${PN}/archive/${PV}.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#pry isn't available for 1.9
#ruby_add_bdepend "test? ( dev-ruby/rails dev-ruby/pry )"

ruby_add_rdepend ">=dev-ruby/activerecord-3.2.10[postgres]"
