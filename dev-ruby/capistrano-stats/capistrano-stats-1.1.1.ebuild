# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/capistrano-stats/capistrano-stats-1.1.1.ebuild,v 1.1 2014/12/31 07:13:39 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRAINSTALL="tasks"

inherit ruby-fakegem

DESCRIPTION="Official metrics to help the development direction of Capistrano"
HOMEPAGE="http://metrics.capistranorb.com/"

LICENSE="MIT"
SLOT="1"
KEYWORDS="~amd64"
IUSE=""
