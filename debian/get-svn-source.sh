#!/bin/sh

set -e

BASE_REL=$(dpkg-parsechangelog 2>/dev/null | sed -ne 's/Version:\s\([0-9\.]\+\)~.*/\1/p')
OLDDIR=${PWD}
GOS_DIR=${OLDDIR}/get-orig-source
SVN_COMMIT='svn log --username anonymous --password "" https://svn.rtmpd.com/crtmpserver/trunk -l 1 | sed -ne "s/r\([0-9]\+\).*/\1/p"'

if [ -z ${BASE_REL} ]; then
	echo 'Please run this script from the sources root directory.'
	exit 1
fi


rm -rf ${GOS_DIR}
mkdir ${GOS_DIR} && cd ${GOS_DIR}
CRTMPSERVER_SVN_COMMIT=$(eval "${SVN_COMMIT}")
svn export -r ${CRTMPSERVER_SVN_COMMIT} --username anonymous --password "" https://svn.rtmpd.com/crtmpserver/trunk \
	crtmpserver-${BASE_REL}~dfsg+svn${CRTMPSERVER_SVN_COMMIT}
cd crtmpserver-${BASE_REL}~dfsg+svn${CRTMPSERVER_SVN_COMMIT}/
cd .. && tar cjf \
	${OLDDIR}/crtmpserver_${BASE_REL}~dfsg+svn${CRTMPSERVER_SVN_COMMIT}.orig.tar.bz2 \
	crtmpserver-${BASE_REL}~dfsg+svn${CRTMPSERVER_SVN_COMMIT} --exclude-vcs --exclude=3rdparty
rm -rf ${GOS_DIR}
